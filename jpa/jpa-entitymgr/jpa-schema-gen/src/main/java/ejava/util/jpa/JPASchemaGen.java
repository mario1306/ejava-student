package ejava.util.jpa;

import javax.persistence.Persistence;

public class JPASchemaGen {
	public static void main(String args[]) {
		if (args!=null && args.length==1) {
			System.out.println("Generating schema for persistence-unit: " + args[0]);
			Persistence.generateSchema(args[0], null);
			System.exit(0);
		} else {
			System.err.println("usage: " + JPASchemaGen.class.getName() + " (persistenceUnit name)");
			throw new RuntimeException("incorrect usage");
		}
	}
}